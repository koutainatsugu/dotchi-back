seed_models = %i[question]
seed_models.each do |model|
  require "./db/seeds/#{model}_seeds"
end