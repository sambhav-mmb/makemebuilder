class UpdateSlugInCategory < ActiveRecord::Migration[5.1]
  def change

  	ServiceCategory.all.each do |sc|
			sc.update(id: sc.id)
		end

		MainCategory.all.each do |mc|
			mc.update(id: mc.id)
		end

		Category.all.each do |c|
			c.update(id: c.id)
		end

  end
end
