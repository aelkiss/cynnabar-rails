describe "GET /awards" do
  it "gets the index" do
    award1 = create(:award)
    award2 = create(:award)
    get awards_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award1.to_s)
    expect(response.body).to include(award2.to_s)
  end
end

describe "GET /awards/new" do
  include_context "when using devise/warden auth"
  it "as a herald, gets a form for a new user" do
    sign_in(create(:user, :herald))
    get new_award_path
    expect(response).to have_http_status(:success)
  end
end

describe "POST /awards" do
  include_context "when using devise/warden auth"
  it "as a herald, allows creating award" do
    sign_in(create(:user, :herald))
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
end

describe "GET /award/:id/edit" do
  include_context "when using devise/warden auth"
  it "as a herald, shows edit form" do
    sign_in(create(:user, :herald))
    award = create(:award)
    get edit_award_path(award)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(award.to_s)
  end
end

describe "PATCH /award/:id" do
  include_context "when using devise/warden auth"
  it "as a herald, updates award" do
    award = create(:award)
    sign_in(create(:user, :herald))
    patch award_path(award), award: attributes_for(:award)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match award_path(award)
  end
end

describe "DELETE /award/:id" do
  include_context "when using devise/warden auth"
  it "as a herald, deletes award" do
    award = create(:award)
    sign_in(create(:user, :herald))
    expect { delete award_path(award) }.to change{Award.count}.by(-1)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match awards_path
  end
end

describe "GET /awards/autocomplete_award_name" do
  include_context "when using devise/warden auth"
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


