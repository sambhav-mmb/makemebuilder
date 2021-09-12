ActiveAdmin.register_page "Dashboard" do

  # menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  menu false

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    # Here is an example of a simple dashboard with columns and panels.
    #

    category1_display = false
    category2_display = false
    category3_display = false
    products_display = false
    blogs_display = false


    if params[:category1].present? && params[:category2].present? && params[:category3].present?
      service_category = ServiceCategory.find(params[:category1])
      main_category = MainCategory.find(params[:category2])
      category = Category.find(params[:category3])
      products = category.products
      blogs = category.blogs
      products_display = true
      blogs_display = true
    elsif params[:category1].present? && params[:category2].present?
      service_category = ServiceCategory.find(params[:category1])
      main_category = MainCategory.find(params[:category2])
      products = main_category.products
      blogs = main_category.blogs
      category3_display = true
    elsif params[:category1].present?
      service_category = ServiceCategory.find(params[:category1])
      products = service_category.products
      blogs = service_category.blogs
      category2_display = true
    else
      category1_display = true
      products = Product.all
      blogs = Blog.all
    end

    columns do
      column class: "column dashobard_section1" do
        panel 'Categories' do
          table_for ServiceCategory do |t|
            t.column("Category 1") { select :id, collection: options_for_select(([["Select Category 1", nil]] + ServiceCategory.all.collect{|c1| [c1.name, c1.id]}).unshift(''), params[:category1])}
            if category1_display == true
              Status.all.each do |status|
                t.column(status.name) {ServiceCategory.where(status_id: status).count}
              end
            end
            t.column('Total') {ServiceCategory.count}
          end

          if params[:category1].present?
            table_for MainCategory do |t|
              main_categories = service_category.main_categories
              t.column("Category 2") { select :id, collection: options_for_select(([["Select Category 2", nil]] + main_categories.collect{|c2| [c2.name, c2.id]}).unshift(''), params[:category2])}
              if category2_display == true
                Status.all.each do |status|
                  t.column(status.name) {main_categories.where(status_id: status).count}
                end
              end
              t.column('Total') {main_categories.count}
            end
          end

          if params[:category1].present? && params[:category2].present?
            table_for Category do |t|
              categories = main_category.categories
              t.column("Category 3") { select :id, collection: options_for_select(([["Select Category 3", nil]] + categories.collect{|c3| [c3.name, c3.id]}).unshift(''), params[:category3])}
              if category3_display == true
                Status.all.each do |status|
                  t.column(status.name) {categories.where(status_id: status).count}
                end
              else
                t.column('Product Total') {category.products.count}
                t.column('Blog Total') {category.blogs.count}
              end
              t.column('Total') {categories.count}
            end
          end

          # if params[:category1].present? && params[:category2].present? && params[:category3].present?
            table_for Product do |t|
              # products = category.products
              t.column("Products")
              Status.all.each do |status|
                t.column(status.name) {products.where(status_id: status).count}
              end
              t.column('Total') {products.count}
            end

            table_for Blog do |t|
              # blogs = category.blogs
              t.column("Blogs")
              Status.all.each do |status|
                t.column(status.name) {blogs.where(status_id: status).count}
              end
              t.column('Total') {blogs.count}
            end
          # end

          table_for User do |t|
            t.column("Users")
            t.column('Total') {User.count}
            t.column('Buyer') {User.where(is_vendor: false).count}
            t.column('Vendor') {User.where(is_vendor: true).count}
          end

          table_for NewsLetter do |t|
            t.column("NewsLetters")
            t.column('Subscribed') {NewsLetter.subscribed.count}
            t.column('Unsubscribed') {NewsLetter.unsubscribed.count}
          end

          table_for "Social" do |t|
            t.column('Facebook') {"N/A"}
            t.column('Linkedin') {"N/A"}
            t.column('Twitter') {"N/A"}
          end
        end
      end

      column class: "column dashobard_section2" do
        panel 'Top 5 Product' do
          arr = Cart.joins(:order).collect(&:cart_items).flatten.map(&:id)
          h = CartItem.where(id: arr).group(:item_id).count
          results = Hash[h.sort_by{|k, v| v}.reverse]
          results.first(5).each_with_index do |result, index| 
            table_for User do |t|
              column do
                "#{index+1}. #{Product.find(result[0]).share_title}"
              end
            end
          end
        end
      end
    end
  end # content
end
