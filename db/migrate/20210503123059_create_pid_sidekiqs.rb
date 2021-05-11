class CreatePidSidekiqs < ActiveRecord::Migration[6.0]
  def change
  	# This model migration is added to manage multiple sidekiq processess at runtime
    create_table :pid_sidekiqs do |t|
      t.datetime :commandAt
      t.string :status
      t.timestamps
    end
  end
end
