class Address < Block
  before_save :before_save_tasks
  before_validation :before_validate_tasks

  COST = 400
  CONSUMER_COST = 200

  # DONT CHANGE THE KEYNAMES FOR THE BELOW HASHES!!!

  MANDATORY_DOCS = {}
  OPTIONAL_DOCS = {} #{:util => "Utility Bill", :pwap => "Passport (with address pages)", :rat => "Ration Card"}
  OTHER_DOCS = {:oth => "Any Other Proof"}
  DOCS = MANDATORY_DOCS.merge(OPTIONAL_DOCS).merge(OTHER_DOCS)
  SUGGESTED_DOCS = MANDATORY_DOCS.merge(OPTIONAL_DOCS).values

  TYPES = %w{Current Permanent Other}
  TYPES_FOR_CONSUMER = [["PERMANENT ADDRESS", "Permanent"],["CURRENT ADDRESS", "Current"]]

  def summary
    a = (a_type == "Other") ? "Address" : a_type + " Address" rescue nil
    b = [a_cit, a_con].reject(&:blank?).join(", ")
    [a, b].reject(&:blank?).join(" : ")

  end

  def overview
    summary
  end

  def other_term
    "Address"
  end

  def before_save_tasks
    if fill_info_flag
      if new?
        self.can_be_ready = can_be_marked_ready?
        # setup_ready_flag
      end
    end
    return true
  end

  def before_validate_tasks
    # if fill_info_flag
    #   # self.ddt = value_for(Settings.addr_type_key)
    #   self.street = value_for(Settings.addr_street_key)
    #   self.city = value_for(Settings.addr_city_key)
    #   self.state = value_for(Settings.addr_state_key)
    #   self.pin = value_for(Settings.addr_pincode_key)
    #   self.country = value_for(Settings.addr_country_key)
    # end
    return true
  end

  def can_be_marked_ready?
    valid? && mandatory_facts_filled?
  end

  def has_sufficient_documents?
    # !artifacts.where(:upload_type => "candidate").empty?
    !artifacts.select{|a| MANDATORY_DOCS.keys.map(&:to_s).include?(a.fact_title)}.empty?
  end

  def is_current_address?
    value_for('a_type') == "Current"
  end

  def is_permanent_address?
    value_for('a_type') == "Permanent"
  end

  def addr_landline_no
    value_for('a_lno')
  end

  def sync_with_facts
    set_value_for('a_add', a_add)
    set_value_for('a_cit', a_cit)
    set_value_for('a_pin', a_pin)
    set_value_for('a_st', a_st)
    set_value_for('a_con', a_con)
    return true
  end

  def first_line
    [a_add, a_cit].reject(&:blank?).join(", ")
  end

  def second_line
    [a_st, a_con, a_pin].reject(&:blank?).join(", ")
  end

  def address_string
    [a_add, a_cit, a_st, a_con, a_pin].reject(&:blank?).join(", ")
  end

  def formatted_address_string
    first_line + "\n" + second_line
  end

  def landmark
    return facts.where(:fact_type_key => 'a_lan').select(:content).first.content
  rescue
    nil
  end

  def landline
    return facts.where(:fact_type_key => 'a_lno').select(:content).first.content
  rescue
    nil
  end

  # Not called frequently, except when testing and validating existing data
  def calculate_percentage_completion
    result = {}
    result[:pc] = ideal_completion[:pc]
    if %w(green amber).include?(status)
      result[:pve] = ideal_completion[:pve]
    # elsif status == "red"
    #   result[:pve] = 20
    end
    result[:pdl] = ideal_completion[:pdl] if !documents.empty? || !personal_links.empty?
    return result
  end

  def percentage_complete
    pc.to_i + pve.to_i + pdl.to_i
  end

  def ideal_completion
    {:pc => 30, :pve => 50, :pdl => 20}
  end

  def action_callouts
    {:pc => "Create It", :pve => "Get Verified", :pdl => "Add Docs/Links"}
  end

  def pending_actions
    [:pc, :pve, :pdl] - done_actions
  end

  def ordered_actions
    [:pc, :pdl, :pve]
  end
end
