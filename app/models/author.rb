class Author < ActiveRecord::Base
  has_and_belongs_to_many :books

  searchkick autocomplete: ['name']

  def to_s
    name
  end
end
