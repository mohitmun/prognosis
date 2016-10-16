# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161016044022) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "answers", force: true do |t|
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_id"
    t.integer  "survey_response_id"
    t.boolean  "qa"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["survey_response_id"], name: "index_answers_on_survey_response_id", using: :btree

  create_table "blocks", force: true do |t|
    t.integer  "profile_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.text     "comments"
    t.boolean  "hidden"
    t.integer  "organization_id"
    t.string   "other_organization"
    t.string   "ddt"
    t.boolean  "latest"
    t.date     "to_date"
    t.date     "from_date"
    t.string   "organization_name"
    t.text     "open_fact_types"
    t.datetime "old_removed_at"
    t.integer  "old_remover_id"
    t.integer  "institute_id"
    t.boolean  "filled_by_candidate"
    t.string   "institute_name"
    t.boolean  "open"
    t.integer  "original_id"
    t.integer  "invoice_id"
    t.boolean  "candidate_approved"
    t.integer  "creator_id"
    t.boolean  "verifier_approved"
    t.boolean  "ready"
    t.integer  "verification_task_id"
    t.boolean  "is_public"
    t.boolean  "can_be_ready"
    t.boolean  "no_documents"
    t.text     "attr_cache"
    t.integer  "bio_block_id"
    t.text     "no_doc_comments"
    t.integer  "linkedin_id"
    t.integer  "candidate_id"
    t.boolean  "is_editable"
    t.boolean  "ignore_in_report"
    t.boolean  "not_present"
    t.boolean  "waiver"
    t.text     "cache"
    t.string   "manual_status"
    t.boolean  "recently_added"
    t.integer  "visibility"
    t.string   "validation_status"
    t.integer  "associated_block_id"
    t.boolean  "show_status"
    t.hstore   "stored_facts"
    t.integer  "reverification_block_id"
    t.integer  "parent_block_id"
    t.integer  "pcc_task_id"
    t.boolean  "is_deleted"
    t.string   "flag",                    limit: nil
    t.string   "company_flag",            limit: nil
  end

  add_index "blocks", ["candidate_id"], name: "index_blocks_on_candidate_id", using: :btree
  add_index "blocks", ["invoice_id"], name: "index_blocks_on_invoice_id", using: :btree
  add_index "blocks", ["organization_id"], name: "index_blocks_on_organization_id", using: :btree
  add_index "blocks", ["pcc_task_id"], name: "index_blocks_on_pcc_task_id", using: :btree
  add_index "blocks", ["profile_id"], name: "index_blocks_on_profile_id", using: :btree
  add_index "blocks", ["verification_task_id"], name: "index_blocks_on_verification_task_id", using: :btree

  create_table "facts", force: true do |t|
    t.integer  "fact_type_id"
    t.text     "content"
    t.string   "status"
    t.text     "comments"
    t.integer  "block_id"
    t.boolean  "visible"
    t.boolean  "mandatory"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "agent_only"
    t.text     "agent_content"
    t.boolean  "hidden"
    t.boolean  "secret"
    t.boolean  "qa"
    t.boolean  "sqa"
    t.text     "previous_content"
    t.string   "fact_type_key"
    t.date     "date_content"
    t.date     "date_agent_content"
  end

  add_index "facts", ["block_id"], name: "index_facts_on_block_id", using: :btree
  add_index "facts", ["fact_type_id"], name: "index_facts_on_fact_type_id", using: :btree

  create_table "lols", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organization_pocs", force: true do |t|
    t.integer  "organization_id"
    t.string   "division"
    t.string   "designation"
    t.string   "department"
    t.text     "process"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "location"
    t.string   "tat"
    t.text     "comments"
    t.string   "location_name"
    t.datetime "deleted_at"
    t.datetime "called_at"
    t.json     "json_store"
  end

  add_index "organization_pocs", ["organization_id"], name: "index_organization_pocs_on_organization_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.string   "organization_type"
    t.string   "other_names"
    t.string   "registration_no"
    t.text     "physical_address"
    t.string   "location"
    t.string   "phone"
    t.string   "email"
    t.string   "accredited_by"
    t.text     "registered_address"
    t.text     "mailing_address"
    t.string   "country_of_registration"
    t.string   "registration_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "alias_id"
    t.boolean  "blacklisted"
    t.string   "website"
    t.boolean  "taken_over"
    t.boolean  "shut_down"
    t.boolean  "suggested_taken_over"
    t.boolean  "suggested_shut_down"
    t.text     "comments"
    t.text     "web_search"
    t.text     "address_check_mode"
    t.text     "address_check_comments"
    t.text     "classified_search"
    t.text     "phone_dir_search"
    t.boolean  "is_temp"
    t.integer  "final_id"
    t.boolean  "allowed_to_issue"
    t.boolean  "untraceable"
    t.integer  "taken_over_org_id"
    t.integer  "data_count"
    t.boolean  "has_changed"
    t.datetime "last_qa_performed_at"
    t.string   "cost_last_checked"
    t.boolean  "removed"
    t.integer  "replace_with"
    t.float    "median_tat"
    t.json     "json_store"
    t.datetime "deleted_at"
    t.boolean  "fake"
  end

  add_index "organizations", ["name", "organization_type"], name: "index_organizations_on_name_and_organization_type", using: :btree
  add_index "organizations", ["name"], name: "index_organizations_on_name", using: :btree
  add_index "organizations", ["organization_type"], name: "index_organizations_on_organization_type", using: :btree

  create_table "profiles", force: true do |t|
    t.text     "start_date"
    t.text     "end_date"
    t.text     "qualification"
    t.text     "education"
    t.text     "skills"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.json     "ratings"
  end

  create_table "questions", force: true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "options"
    t.integer  "survey_id"
    t.string   "data_type"
    t.boolean  "mandatory"
    t.integer  "display_order"
    t.integer  "template_question_id"
    t.datetime "removed_at"
    t.string   "context"
    t.boolean  "is_template"
    t.string   "ft_key"
  end

  add_index "questions", ["survey_id"], name: "index_questions_on_survey_id", using: :btree
  add_index "questions", ["template_question_id"], name: "index_questions_on_template_question_id", using: :btree

  create_table "verification_task_payments", force: true do |t|
    t.string   "mode"
    t.string   "beneficiary_name"
    t.datetime "payable_at"
    t.string   "amount"
    t.string   "charges"
    t.text     "amount_in_words"
    t.string   "branch_code"
    t.string   "bank"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.datetime "completed_at"
    t.integer  "verification_task_id"
    t.string   "status"
    t.string   "payable_location"
    t.integer  "creator_id"
    t.datetime "canceled_at"
    t.string   "reference_no",         limit: nil
  end

  create_table "verification_task_tats", force: true do |t|
    t.datetime "initiated_at"
    t.datetime "closed_at"
    t.integer  "tat"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "verification_task_id"
    t.string   "status"
  end

  create_table "verification_tasks", force: true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "verification_request_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agent_id"
    t.datetime "allocated_at"
    t.string   "means_of_verification"
    t.datetime "accepted_at"
    t.datetime "initiated_at"
    t.datetime "returned_at"
    t.integer  "vendor_id"
    t.text     "case_notes"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "completed_at"
    t.integer  "organization_poc_id"
    t.integer  "vendor_poc_id"
    t.string   "block_type"
    t.integer  "invoice_id"
    t.integer  "profile_id"
    t.string   "rejection_comments"
    t.float    "cost"
    t.boolean  "include_organization"
    t.boolean  "include_institute"
    t.integer  "mapped_institute_id"
    t.integer  "mapped_organization_id"
    t.boolean  "qa"
    t.datetime "qa_performed_at"
    t.integer  "qa_agent_id"
    t.datetime "closed_until"
    t.datetime "qa_closed_until"
    t.boolean  "sqa"
    t.datetime "sqa_performed_at"
    t.integer  "sqa_agent_id"
    t.text     "qa_flags"
    t.text     "sqa_flags"
    t.string   "summary"
    t.datetime "qa_allocated_at"
    t.datetime "approved_at"
    t.integer  "etat"
    t.integer  "atat"
    t.text     "options"
    t.integer  "temp_organization_id"
    t.integer  "temp_institute_id"
    t.boolean  "is_validation"
    t.datetime "next_reminder_set_for"
    t.datetime "last_activity_at"
    t.datetime "delayed_at"
    t.boolean  "ignore_from_invoice"
    t.integer  "related_task_id"
    t.datetime "effective_initiated_at"
    t.integer  "survey_response_id"
    t.date     "reopen_date"
    t.datetime "actual_approved_at"
    t.boolean  "accept_documents"
    t.string   "initiated_by"
    t.boolean  "auto"
    t.json     "timeline"
    t.integer  "priority"
    t.integer  "yog"
    t.json     "json_store"
    t.float    "otat"
    t.integer  "city_id"
    t.float    "estimated_cost",                      default: 0.0,            null: false
    t.string   "task_type",               limit: nil, default: "verification"
    t.uuid     "public_id"
    t.integer  "reverification_task_id"
    t.integer  "parent_task_id"
    t.string   "flag",                    limit: nil
    t.json     "closure_details"
    t.string   "company_flag",            limit: nil
  end

  add_index "verification_tasks", ["status"], name: "index_verification_tasks_on_status", using: :btree
  add_index "verification_tasks", ["verification_request_id"], name: "index_verification_tasks_on_verification_request_id", using: :btree

end
