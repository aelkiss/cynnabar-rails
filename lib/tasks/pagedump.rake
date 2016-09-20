# frozen_string_literal: true
require 'fileutils'

namespace :db do
  desc 'Dump pages from database to directory'
  task pagedump: :environment do
    basedir = "#{Rails.root}/db/db_export"

    File.open("#{basedir}/page_title.tsv", 'w') do |index|
      Page.find_each do |page|
        begin
          index.puts [page.id, page.slug, page.title].join("\t")
          filename = "#{basedir}/page/#{page.slug}.html"
          FileUtils.mkdir_p File.dirname(filename)

          File.open(filename, 'w') do |file|
            file.write(page.body)
            puts "Page #{page.slug} saved"
          end
        rescue IOError => error
          puts "Page #{page.slug}: could not save: IOError: #{error}"
        end
      end
    end
  end
end
