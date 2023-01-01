require "rails_helper"
RSpec.describe User, type: :model do
  it "uidは一意であり、そうでなければ保存ができない"
end
