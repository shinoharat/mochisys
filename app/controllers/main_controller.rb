class MainController < ApplicationController
  # GET /
  def index
    @templates = Template.all
    @clothing_brands = ClothingBrand.all
    @designs = Design.all
    @material_brands = MaterialBrand.all
    @colors = Color.all
    @conditions = conditions
    @condition_details = condition_details
  end

  # GET /logout
  def logout
    render plain: 'logout', status: :unauthorized
  end

  private

  def conditions
    [
      ["新品未使用"],
      ["新品同様"],
      ["極美品"],
      ["美品"],
      ["なし"],
    ]
  end

  def condition_details
    ConditionDetail.all.map do |rec|
      desplay = rec.name.presence || rec.description.truncate(35)
      value = '<span style="color:' + rec.color_code + ';">' + rec.description + '</span>'
      [desplay, value, { 'data-tags': rec.tags }]
    end
  end
end
