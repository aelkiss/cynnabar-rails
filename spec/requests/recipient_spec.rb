require "rails_helper" 

describe "GET /recipients" do
  it "gets the index" do
    recipient1 = create(:recipient)
    recipient2 = create(:recipient)
    get recipients_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(recipient1.to_s)
    expect(response.body).to include(recipient2.to_s)
  end

  it "can search by mundane name" do
    recipient1 = create(:recipient, mundane_name: 'Mundane One')
    recipient2 = create(:recipient, mundane_name: 'Mundane Two')
    get recipients_path, search: 'Mundane One'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(recipient1.to_s)
    expect(response.body).not_to include(recipient2.to_s)
  end

  it "can search by sca name" do
    recipient1 = create(:recipient, sca_name: 'Scaname One')
    recipient2 = create(:recipient, sca_name: 'Scaname Two')
    get recipients_path, search: 'Scaname One'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(recipient1.to_s)
    expect(response.body).not_to include(recipient2.to_s)
  end

  it "includes awardings when searching" do
    awarding = create(:awarding)
    get recipients_path, search: awarding.recipient.mundane_name
    expect(response).to have_http_status(:success)
    expect(response.body).to include(awarding.award.to_s)
  end
end

describe "GET /recipients/new" do
  it "as a herald, gets a form for a new user" do
    sign_in(create(:user, :herald))
    get new_recipient_path
    expect(response).to have_http_status(:success)
  end
end

describe "POST /recipients" do
  it "as a herald, allows creating recipient" do
    sign_in(create(:user, :herald))
    expect { post recipients_path, recipient: attributes_for(:recipient) }.to change{Recipient.count}.by(1)
    expect(response).to have_http_status(:redirect)
  end

  it "as a normal user, does not allow creating recipient" do
    sign_in(create(:user))
    expect { post recipients_path, recipient: attributes_for(:recipient) }.to change{Recipient.count}.by(0)
    expect(response).to have_http_status(:forbidden)
  end
end

describe "GET /recipient/:id" do
  it "shows recipient" do
    recipient = create(:recipient)
    get recipient_path(recipient)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(recipient.to_s)
  end

  it "includes preferred pronouns" do
    recipient = create(:recipient, :pronouns)
    get recipient_path(recipient)
    expect(response.body).to include(recipient.pronouns)
  end
end

describe "GET /recipient/:id/edit" do
  it "as a herald, shows edit form" do
    sign_in(create(:user, :herald))
    recipient = create(:recipient)
    get edit_recipient_path(recipient)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(recipient.to_s)
  end
end

describe "PATCH /recipient/:id" do
  context "as a herald" do
    before(:each) do 
      sign_in(create(:user, :herald))
    end

    it "can update recipient" do
      recipient = create(:recipient)
      patch recipient_path(recipient), recipient: attributes_for(:recipient)
      expect(response).to have_http_status(:redirect)
      expect(response.redirect_url).to match recipient_path(recipient)
    end

    it "can edit title" do
      recipient = create(:recipient)
      patch recipient_path(recipient), recipient: {title: 'Mytitle'}
      # reload
      recipient = Recipient.find(recipient.id)
      expect(recipient.title).to eq('Mytitle')
    end

    it "can edit pronouns" do
      recipient = create(:recipient)
      patch recipient_path(recipient), recipient: {pronouns: 'Pronouns'}
      # reload
      recipient = Recipient.find(recipient.id)
      expect(recipient.pronouns).to eq('Pronouns')
    end

  end
end

describe "DELETE /recipient/:id" do
  it "as an admin, deletes recipient" do
    recipient = create(:recipient)
    sign_in(create(:user, :admin))
    expect { delete recipient_path(recipient) }.to change{Recipient.count}.by(-1)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match recipients_path
  end
end

describe "GET /recipients/autocomplete_recipient_name" do
  context "when signed in as a herald" do
    before(:each) { sign_in create(:user,:herald) }

    it "autocompletes recipient name" do
      recipient = create(:recipient)
      get "/recipients/autocomplete_recipient_name",  term: recipient.mundane_name.split(" ")[0].downcase
      response_obj = JSON.parse(@response.body)
      expect(response_obj[0]["id"].to_i).to eq(recipient.id)
    end

    it "returns multiple options for autocomplete" do
      recipient1 = create(:recipient)
      recipient2 = create(:recipient)
      get "/recipients/autocomplete_recipient_name",  term: "name"
      response_obj = JSON.parse(@response.body)
      expect(response_obj.length).to eq(Recipient.count)
    end
  end

end


