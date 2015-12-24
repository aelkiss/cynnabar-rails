
describe "pages/show.html.erb" do
  context 'when logged in as a regular user' do
    it "has an edit link for pages owned by that user" do
      user = create(:user)
      page = build(:page, user: user)
      render_page_for_user(page,user)
      expect(rendered).to have_selector "a[href='/#{page.slug}/edit']"
    end

    it "does not have an edit link for pages not owned by that user" do
      user1 = create(:user)
      user2 = create(:user)
      page = build(:page, user: user1)
      render_page_for_user(page,user2)
      expect(rendered).not_to have_selector "a[href='/#{page.slug}/edit']"
    end

    it "does not have an index link" do
      page = build(:page)
      render_page_for_user(page,build(:user))
      expect(rendered).not_to have_selector "a[href='/pages']"
    end
  end

  context 'when logged in as an admin' do

    it "has an edit link" do
      page = build(:page)
      render_page_for_user(page,build(:user, :admin))
      expect(rendered).to have_selector "a[href='/#{page.slug}/edit']"
    end

    it "has a list pages link" do
      render_page_for_user(build(:page),build(:user, :admin))
      expect(rendered).to have_selector "a[href='/pages']"
    end

  end


  context 'when not logged in' do
    it "does not have an edit link" do
      page = build(:page)
      render_page_for_user(page,nil)
      expect(rendered).not_to have_selector "a[href='/#{page.slug}/edit']"
    end

    it "does not have an index link" do
      render_page_for_user(build(:page),nil)
      expect(rendered).not_to have_selector "a[href='/pages']"
    end
  end

  context 'when the page has an office' do
    it "shows the office info" do
      office = create(:office)
      page = build(:page, office: office)
      render_page_for_user(page,nil)
      expect(rendered).to have_content office.name 
      expect(rendered).to have_selector "a[href='mailto:#{office.email}']"
      expect(rendered).to have_selector "img[src='#{office.image}']"
      expect(rendered).to have_content office.officer_name 
    end
  end


  def render_page_for_user(page,user)
    user ||= User.new()
    controller.request.path_parameters[:slug] = page.slug
    controller.sign_in(user)
    assign(:page, page)

    render
  end
end
