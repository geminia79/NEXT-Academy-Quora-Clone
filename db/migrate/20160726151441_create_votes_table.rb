class CreateVotesTable < ActiveRecord::Migration
	def change
		create_table :question_votes do |t|
			t.belongs_to :question, index: true
			t.belongs_to :user, index: true
			t.integer :vote
			t.timestamps
		end
	end
		create_table :answer_votes do |t|
			t.belongs_to :answer, index: true
			t.belongs_to :user, index: true
			t.integer :vote
			t.timestamps
		end
end
