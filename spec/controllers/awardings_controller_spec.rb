require 'rails_helper' 

describe AwardingsController, type: :controller do

  it "when given a date range, filters awards by date" do
    newaward = create(:awarding,received: '2015-01-01')
    oldaward = create(:awarding,received: '1970-01-01')
    get(:index, { start_date: '2010-01-01', end_date: '2019-01-01' })
    expect(response).to have_http_status(:success)
    expect(assigns(:awardings)).to include(newaward)
    expect(assigns(:awardings)).not_to include(oldaward)
  end

  it "when given an invalid date, flashes an error" do
    get(:index, { start_date: 'THIS IS NOT A DATE', end_date: '2019-01-01' })
    expect(response).to have_http_status(:success)
    expect(flash[:error]).to match(/date/i)
  end

  it "when given only one date, flashes an error" do
    get(:index, { end_date: '2019-01-01' })
    expect(response).to have_http_status(:success)
    expect(flash[:error]).to match(/date.*both/i)
  end

end
