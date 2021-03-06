class RubossControllerGenerator < Merb::GeneratorBase
  include RubossOnRuby::Configuration

  default_options :author => nil
  
  attr_reader :project_name, 
              :flex_project_name, 
              :base_package, 
              :base_folder, 
              :command_controller_name,
              :model_names, 
              :command_names

  def initialize(runtime_args, runtime_options = {})
    runtime_args.push ""
    super
    @name = 'ruboss_controller'
    @project_name, @flex_project_name, @command_controller_name, @base_package, @base_folder = extract_names
    
    @model_names = list_as_files("app/flex/#{base_folder}/models")
    @command_names = list_as_files("app/flex/#{base_folder}/commands")
  end

  def manifest
    record do |m|      
      m.template 'controller.as.erb', File.join("app/flex/#{base_folder}/controllers", 
        "#{command_controller_name}.as")
    end
  end

  protected
    def banner
      "Usage: #{$0} #{spec.name}" 
    end
end