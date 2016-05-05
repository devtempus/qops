class Category < ActiveRecord::Base
  has_ancestry cache_depth: true

  has_many :categories_quotations
  has_and_belongs_to_many :quotations, through: :categories_quotations
  validates_presence_of :name

  scope :publicated, -> { where(published: true)}

  class << self
    def arrange_as_array(options={}, hash=nil)
      hash ||= arrange(options)

      arr = []
      hash.each do |node, children|
        arr << node
        arr += arrange_as_array(options, children) unless children.nil?
      end
      arr
    end
  end

  def name_for_selects
    "#{'&nbsp;' * depth} #{name}".html_safe
  end

  def possible_parents
    Category.arrange_as_array(order: 'name')
    # return new_record? ? parents : parents - subtree
  end

end
