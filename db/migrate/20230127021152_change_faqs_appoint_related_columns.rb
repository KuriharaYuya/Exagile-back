class ChangeFaqsAppointRelatedColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :faqs, :appoint_id
    remove_column :faqs, :inspired
    remove_column :faqs, :applied
    add_column :faqs, :inspired_appoint_id, :string
    add_column :faqs, :applied_appoint_id, :string
  end
end
