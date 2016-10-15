class VerificationTask < ActiveRecord::Base
  has_many :answers, foreign_key: "survey_response_id", primary_key: "survey_response_id"
end