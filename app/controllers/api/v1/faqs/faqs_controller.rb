module Api
  module V1
    module Faqs
      class FaqsController < ApplicationController
        include ::Api::V1::Auth::SessionHelper
        before_action :authenticate_user

        def update
          faq = Faq.find(params[:id])
          name, content = params[:faq].values_at("name", "content")
          return unless faq.user == current_user

          faq.update(name:, content:) && faq.save
          render json: { faq: }, status: :ok
        end

        def destroy
          faq = Faq.find(params[:id])
          return unless faq.user == current_user

          render json: {}, status: :ok if faq.destroy
        end

        def create
          faq_type, name, content, appoint_id = params[:faq].values_at("faq_type", "name", "content", "appoint_id")
          appoint = Appoint.find(appoint_id)
          return unless appoint.user == current_user

          type_id = "#{faq_type}_id"
          faq = current_user.faqs.build(type_id.to_sym => appoint_id, name:, content:)
          render json: { faq: }, status: :ok if faq.save
        end
      end
    end
  end
end
