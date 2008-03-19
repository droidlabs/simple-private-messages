class PrivateMessageModelGenerator < Rails::Generator::NamedBase

  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name

  def initialize(runtime_args, runtime_options = {})
    super
    
    @singular_camel_case_name = @name.singularize.camelize
    @plural_camel_case_name = @name.pluralize.camelize
    @singular_lower_case_name = @name.singularize.underscore
    @plural_lower_case_name = @name.pluralize.underscore
  end
  
  def manifest
    record do |m|
      m.directory "app/models"
      m.template "model.rb", "app/models/#{singular_lower_case_name}.rb"
      
      m.migration_template "migration.rb", "db/migrate", :assigns => {
        :migration_name => "Create#{plural_camel_case_name}"
      }, :migration_file_name => "create_#{plural_lower_case_name}"
    end
  end
end
