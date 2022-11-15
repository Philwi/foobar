namespace :export do
  desc "Export Database"
  task :export_to_seeds => :environment do
    tables_to_create = %w[Spot SurflineSpot SurflineCondition]
    tables_to_create.each do |table|
      table.constantize.all.each do |entry|
        excluded_keys = %w[created_at updated_at id]

        serialized = entry.serializable_hash.delete_if { |key, _value| excluded_keys.include?(key) }
        puts "#{table.constantize}.create(#{serialized})"
      end
    end
  end
end
