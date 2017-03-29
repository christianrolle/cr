# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { build(:article) }

  it { is_expected.to have_many(:article_tag_positions) }
end
