ActiveAdmin.register UserStatusTracking do
  menu false

  actions :all, except: [:new, :create, :edit, :update, :destroy]

  index do
    id_column
    column "Vendor Status" do |t|
      User::VENDOR_STATUS[t.vendor_status]
    end
    column :date
    column "Vendor Status" do |t|
     t.user.name
    end
    actions
  end

end