class SearchUserItemForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  # 検索用のmodelを作成
  attribute :user_id, :integer
  attribute :maker_id, :integer

  def search
    relation = Item.distinct

    relation = relation.own_user(user_id) if user_id.present?
    relation = relation.by_maker(maker_id) if maker_id.present?
    relation
  end
end
