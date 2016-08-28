require 'rails_helper'

RSpec.describe "pages/home", type: :view do
  it "renders home page correctly" do
    render
    expect(rendered).to render_template("home")
  end
end
