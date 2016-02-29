require "rails_helper"

describe "GET /awards" do
  it "gets the index" do
    award1 = create(:award)
    award2 = create(:award)
    get awards_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award1.to_s)
    expect(response.body).to include(award2.to_s)
  end

  it "can search by award name" do
    award1 = create(:award, name: 'Award 1')
    award2 = create(:award, name: 'Award 2')
    get awards_path, search: 'Award 1'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award1.to_s)
    expect(response.body).not_to include(award2.to_s)
  end

  it "can search by award description" do
    award1 = create(:award, name: 'Award 1', description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit,')
    award2 = create(:award, name: 'Award 2', description: 'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua')
    get awards_path, search: 'lorem'
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award1.to_s)
    expect(response.body).not_to include(award2.to_s)
  end

  it "includes awardings when searching" do
    awarding = create(:awarding)
    get awards_path, search: awarding.award.name
    expect(response).to have_http_status(:success)
    expect(response.body).to include(awarding.recipient.to_s)
  end
end

describe "GET /awards/new" do
  it "as an admin, gets a form for a new award" do
    sign_in(create(:user, :admin))
    get new_award_path
    expect(response).to have_http_status(:success)
  end
end

describe "POST /awards" do
  it "as an admin, allows creating award" do
    sign_in(create(:user, :admin))
    expect { post awards_path, award: attributes_for(:award) }.to change{Award.count}.by(1)
    expect(response).to have_http_status(:redirect)
  end

  it "as a normal user, does not allow creating award" do
    sign_in(create(:user))
    expect { post awards_path, award: attributes_for(:award) }.to change{Award.count}.by(0)
    expect(response).to have_http_status(:forbidden)
  end
end

describe "GET /award/:id" do
  it "shows award" do
    award = create(:award)
    get award_path(award)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award.to_s)
  end

  it "shows the default granter for the award" do
    award = create(:award, :hasgroup)
    get award_path(award)
    expect(response.body).to include(award.group.name)
  end

  it "does not show the default granter for society-level awards" do
    award = create(:award, :hasgroup, :society)
    get award_path(award)
    expect(response.body).not_to include(award.group.name)
  end

end

describe "GET /award/:id/edit" do
  it "as an admin, shows edit form" do
    sign_in(create(:user, :admin))
    award = create(:award)
    get edit_award_path(award)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award.to_s)
  end
end

describe "PATCH /award/:id" do
  it "as an admin, updates award" do
    award = create(:award)
    sign_in(create(:user, :admin))
    patch award_path(award), award: attributes_for(:award)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match award_path(award)
  end
end

describe "DELETE /award/:id" do
  it "as an admin, deletes award" do
    award = create(:award)
    sign_in(create(:user, :admin))
    expect { delete award_path(award) }.to change{Award.count}.by(-1)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match awards_path
  end
end

describe "GET /awards/autocomplete_award_name" do
  context "when signed in as a herald" do
    before(:each) { sign_in create(:user,:herald) }

    it "autocompletes award name" do
      award = create(:award)
      get "/awards/autocomplete_award_name",  term: award.to_s.split(" ")[0].downcase
      response_obj = JSON.parse(@response.body)
      expect(response_obj[0]["id"].to_i).to eq(award.id)
    end
  end

end


