require "rails_helper" 

describe "GET /awardings" do
  it "gets the index" do
    awarding1 = create(:awarding)
    awarding2 = create(:awarding)
    get awardings_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include(awarding1.to_s)
    expect(response.body).to include(awarding2.to_s)
  end
end

describe "GET /awardings/new" do
  it "as a herald, gets a form for a new awarding" do
    sign_in(create(:user, :herald))
    get new_awarding_path
    expect(response).to have_http_status(:success)
  end

  it "when not logged in, does not get a form for a new awarding" do
    get new_awarding_path
    expect(response).to have_http_status(:forbidden)
  end
end

describe "POST /awardings" do
  def post_awardings
    post awardings_path, awarding: build(:awarding).attributes 
  end

  context "when logged in as a herald" do
    before(:each) do 
      sign_in(create(:user, :herald))
    end

    it "allows creating awarding" do
      expect { post_awardings }.to change{Awarding.count}.by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "allows adding fields for foreign awards" do
      attrs = build(:awarding, :other).attributes
      # other_award: required check box not to dump foreign award attributes
      post awardings_path, awarding: attrs, other_award: '1'
      expect(response).to have_http_status(:redirect)
      expect(Awarding.find_by_award_name(attrs['award_name'])).not_to be_nil
    end

    it "allows adding award text" do
      attrs = build(:awarding, :text).attributes
      post awardings_path, awarding: attrs
      expect(response).to have_http_status(:redirect)
      expect(Awarding.find_by_award_name(attrs['award_name']).award_text).to eq(attrs['award_text'])
    end
  end


  it "as a normal user, does not allow creating awarding" do
    sign_in(create(:user))
    expect { post_awardings }.to change{Awarding.count}.by(0)
    expect(response).to have_http_status(:forbidden)
  end

  it "when not logged in, does not allow creating awarding" do
    expect { post_awardings }.to change{Awarding.count}.by(0)
    expect(response).to have_http_status(:forbidden)
  end

end

describe "GET /awarding/:id" do
  it "shows awarding" do
    awarding = create(:awarding)
    get awarding_path(awarding)
    expect(response).to have_http_status(:success)
    expect(response.body).to include(awarding.to_s)
  end

  it "shows award text" do
    awarding = create(:awarding, :text)
    get awarding_path(awarding)
    expect(response.body).to include(awarding.award_text)
  end

end

describe "GET /awarding/:id/edit" do
  it "as a herald, updates awarding" do
    awarding = create(:awarding)
    sign_in(create(:user, :herald))
    patch awarding_path(awarding), awarding: build(:awarding).attributes
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match awarding_path(awarding)
  end

  it "when not logged in, does not update awarding" do
    awarding = create(:awarding)
    patch awarding_path(awarding), awarding: build(:awarding).attributes 
    expect(response).to have_http_status(:forbidden)
  end
end

describe "DELETE /awarding/:id" do
  it "as a herald, deletes awarding" do
    awarding = create(:awarding)
    sign_in(create(:user, :herald))
    expect { delete awarding_path(awarding) }.to change{Awarding.count}.by(-1)
    expect(response).to have_http_status(:redirect)
    expect(response.redirect_url).to match awardings_path
  end

  it "when not logged in, does not destroy awarding" do
    awarding = create(:awarding)
    expect { delete awarding_path(awarding) }.to change{Awarding.count}.by(0)
    expect(response).to have_http_status(:forbidden)
  end
end
