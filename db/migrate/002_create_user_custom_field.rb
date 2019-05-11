# noinspection RubyResolve,RubyClassModuleNamingConvention
class CreateUserCustomField < ActiveRecord::Migration[5.1]

  def self.up
    create_custom_fields
  end

  def self.down
    delete_custom_fields
  end


  def self.create_custom_fields
    UserCustomField.create!([{
                                 name: "Munkaóra/Hét",
                                 field_format: "int",
                                 is_required: true,
                                 is_filter: true,
                                 editable: true,
                                 visible: true}
                            ])
  end

  def self.delete_custom_fields
    UserCustomField.destroy_all(name: "Munkaóra/Hét")
  end

end