modules_path = File.join(Rails.root, 'config/mods/')
product_modules = {}
product_modules[:module_names] = []
product_modules[:module_resources] = {}
resources = {}

Dir.foreach(modules_path) do |mod|
  next if mod.start_with?('.')
  product_modules[:module_names] << mod
  product_modules[mod.to_sym] = {}
  Dir.foreach(modules_path + mod) do |resource|
    next if resource.start_with?('.')
    product_modules[mod.to_sym][resource.to_sym] = {}
    product_modules[:module_resources][resource.to_sym] = {}
    resources[resource.to_sym] ||= []
    resource_types = []
    Dir.foreach(modules_path + mod + '/' + resource) do |file|
      next if file.start_with?('.')
      file_path = modules_path + mod + '/' + resource + '/' + file
      file_name = File.basename(file, '.json')
      resource_types << file_name
      product_modules[mod.to_sym][resource.to_sym][file_name.to_sym] = JSON.parse(File.read(file_path))
    end
    resources[resource.to_sym].concat(resource_types)
  end
end
product_modules[:module_resources] = resources

Rails.application.config.jellyfish_product_modules = product_modules