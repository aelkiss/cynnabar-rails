
describe "pages/show.html.erb" do
  context 'when logged in as a regular user' do
    it "has an edit link for pages owned by that user" do
      user = create(:user)
      page = build(:page, user: user)
      render_page_for_user(page,user)
      expect(rendered).to have_selector "a[href='/#{page.slug}/edit']"
    end

    it "does not have an edit link for pages not owned by that user" do
      user = create(:user)
      page = build(:page, user: user)
      render_page_for_user(page,create(:user))
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

  def render_page_for_user(page,user)
    controller.request.path_parameters[:slug] = page.slug
    controller.sign_in(user)
    assign(:page, page)

    render
  end
end
