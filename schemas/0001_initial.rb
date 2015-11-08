schema "0001 initial" do

  # Examples:
  #
  entity "Game" do
    string :name
    string :location
    integer32 :api_id
  end

  # entity "Post" do
  #   string :title, optional: false
  #   string :body
  #
  #   datetime :created_at
  #   datetime :updated_at
  #
  #   has_many :replies, inverse: "Post.parent"
  #   belongs_to :parent, inverse: "Post.replies"
  #
  #   belongs_to :person
  # end

end
