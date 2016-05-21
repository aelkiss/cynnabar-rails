require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

namespace :calendar do
  task :update do
    CONFIG_PATH = "#{::Rails.root}/config".freeze
    config = YAML.load_file("#{CONFIG_PATH}/calendar.yml")
    OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'.freeze
    APPLICATION_NAME = config['application_name']
    CLIENT_SECRETS_PATH = "#{CONFIG_PATH}/#{config['client_secrets_path']}".freeze
    CREDENTIALS_PATH = "#{CONFIG_PATH}/#{config['credentials_path']}".freeze
    OUTPUT_PATH = "#{CONFIG_PATH}/#{config['json_output_path']}".freeze
    SCOPE = config['scope']

    def authorize
      FileUtils.mkdir_p(File.dirname(CREDENTIALS_PATH))

      client_id = Google::Auth::ClientId.from_file(CLIENT_SECRETS_PATH)
      token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
      authorizer = Google::Auth::UserAuthorizer.new(
        client_id, SCOPE, token_store)
      user_id = 'default'
      credentials = authorizer.get_credentials(user_id)
      if credentials.nil?
        url = authorizer.get_authorization_url(
          base_url: OOB_URI)
        puts 'Open the following URL in the browser and enter the ' \
             'resulting code after authorization'
        puts url
        code = gets
        credentials = authorizer.get_and_store_credentials_from_code(
          user_id: user_id, code: code, base_url: OOB_URI)
      end
      credentials
    end

    # Initialize the API
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = APPLICATION_NAME
    service.authorization = authorize

    # Initialize the API
    #    client = Google::APIClient.new(:application_name => APPLICATION_NAME)
    #    client.authorization = authorize
    calendar_api = Google::Apis::CalendarV3::CalendarService.new

    calendars = config['calendars']
    queries = config['queries']
    calendars_invert = calendars.invert

    results = service.list_calendar_lists

    results.items.each do |calendar|
      calendar_sym = calendars_invert[calendar.summary]
      calendars[calendar_sym] = calendar.id if calendar_sym
    end

    queries.each do |sym, query|
      puts "CALENDAR QUERY FOR #{sym}"

      if query['calendar'] == 'all'
        query['calendars'] = calendars.keys
      else
        query['calendars'] ||= [query['calendar']]
      end
      query['horizon'] ||= 6
      query['max_results'] ||= 12
      query['query'] ||= /.*/

      timeMax = Date.today >> query['horizon']

      events = []
      query['calendars'].each do |calendar_sym|
        events += service.list_events(
          calendars[calendar_sym],
          single_events: true,
          order_by: 'startTime',
          time_min: Date.today.to_time.iso8601,
          time_max: (Date.today >> query['horizon']).to_time.iso8601
        ).items.select { |e| e.summary.match(query['query']) }
      end
      sorted_events = events.sort_by { |e| e.start.date_time }.first(query['max_results'])
      hash_events = sorted_events.map do |event|
        Hash[[:description, :end, :html_link, :location, :start, :summary].map do |field|
          [field.to_s, event.send(field)]
        end]
      end
      hash_events.each do |event|
        event['start'] = event['start'].date_time
        event['end'] = event['end'].date_time
      end

      File.open("#{OUTPUT_PATH}/#{sym}.json", 'w') do |file|
        file.write({ events: hash_events,
                     link: query['link'] }.to_json)
      end
    end
  end
end
