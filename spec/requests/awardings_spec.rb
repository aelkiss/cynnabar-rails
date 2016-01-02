describe "GET /awardings" do
  it "gets the index" do
    awarding1 = create(:awarding)
    awarding2 = create(:awarding)
    get awardings_path
    expect(response.status).to eq(200)
    expect(response.body).to include(awarding1.to_s)
    expect(response.body).to include(awarding2.to_s)
  end
end

describe "GET /awardings/new" do
  include_context "when using devise/warden auth"
  it "as a herald, gets a form for a new awarding" do
    sign_in(create(:user, :herald))
    get new_awarding_path
    expect(response.status).to eq(200)
  end

  it "when not logged in, does not get a form for a new awarding" do
    get new_awarding_path
    expect(response.status).to eq(403)
  end
end

describe "POST /awardings" do
  def post_awardings
    post awardings_path, awarding: build(:awarding).attributes 
  end

  include_context "when using devise/warden auth"
  it "as a herald, allows creating awarding" do
    sign_in(create(:user, :herald))
    expect { post_awardings }.to change{Awarding.count}.by(1)
    expect(response.status).to eq(302)
  end

  it "as a normal user, does not allow creating awarding" do
    sign_in(create(:user))
    expect { post_awardings }.to change{Awarding.count}.by(0)
    expect(response.status).to eq(403)
  end

  it "when not logged in, does not allow creating awarding" do
    expect { post_awardings }.to change{Awarding.count}.by(0)
    expect(response.status).to eq(403)
  end
end

describe "GET /awarding/:id" do
  it "shows awarding" do
    awarding = create(:awarding)
    get awarding_path(awarding)
    expect(response.status).to eq(200)
    expect(response.body).to include(awarding.to_s)
  end
end

describe "GET /awarding/:id/edit" do
  include_context "when using devise/warden auth"
  it "as a herald, shows edit form" do
    sign_in(create(:user, :herald))
    awarding = create(:awarding)
    get edit_awarding_path(awarding)
    expect(response.status).to eq(200)
    expect(response.body).to include(awarding.to_s)
  end

  it "when not logged in, does not get edit form" do
    get edit_awarding_path(create(:awarding))
    expect(response.status).to eq(403)
  end
end

describe "PATCH /awarding/:id" do
  include_context "when using devise/warden auth"
  it "as a herald, updates awarding" do
    awarding = create(:awarding)
    sign_in(create(:user, :herald))
    patch awarding_path(awarding), awarding: build(:awarding).attributes
    expect(response.status).to eq(302)
    expect(response.redirect_url).to match awarding_path(awarding)
  end

  it "when not logged in, does not update awarding" do
    awarding = create(:awarding)
    patch awarding_path(awarding), awarding: build(:awarding).attributes 
    expect(response.status).to eq(403)
  end
end

describe "DELETE /awarding/:id" do
  include_context "when using devise/warden auth"
  it "as a herald, deletes awarding" do
    awarding = create(:awarding)
    sign_in(create(:user, :herald))
    expect { delete awarding_path(awarding) }.to change{Awarding.count}.by(-1)
    expect(response.status).to eq(302)
    expect(response.redirect_url).to match awardings_path
  end

  it "when not logged in, does not destroy awarding" do
    awarding = create(:awarding)
    expect { delete awarding_path(awarding) }.to change{Awarding.count}.by(0)
    expect(response.status).to eq(403)
  end
end
