class AppendCareerCode < ActiveRecord::Migration[5.1]
  def up
    Rake::Task["career:migrate_code"].invoke
  end

  def down
    Rake::Task["career:reverse_migrate_code"].invoke
  end
end
