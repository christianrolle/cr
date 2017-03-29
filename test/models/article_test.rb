require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def test_valid_article
    assert @article.valid?
  end

  def setup
    @article = FactoryGirl.build :article
  end
end
