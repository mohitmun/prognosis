class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :verification_task, foreign_key: "survey_response_id", primary_key: "survey_response_id"
end