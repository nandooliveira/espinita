# frozen_string_literal: true

module Espinita
  module AuditorRequest
    extend ActiveSupport::Concern

    included do
      before_action :store_audited_user
    end

    def store_audited_user
      # assign current_user if defined
      RequestStore.store[:audited_user] = send(Espinita.current_user_method) \
        if respond_to?(Espinita.current_user_method, include_private = true)

      RequestStore.store[:audited_ip]   = try(:request).try(:remote_ip)
    end
  end
end
