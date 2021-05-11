class CreatePidSidekiqs < ActiveRecord::Migration[6.0]
  def change
    create_table :pid_sidekiqs do |t|
      t.string :status
      t.datetime :commandAt

      t.timestamps
    end
  end
end
