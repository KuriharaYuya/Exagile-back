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

        def index
          p current_user
          options = current_user.manipulate_options["faqs"]
          length = current_user.faqs.length
          data_qty = params[:data_qty].to_i
          faqs_data = current_user.faqs.order(created_at: options["sort"]["created_at"])
          # faqs_data = faqs_data.sort_by { |f| f.faq_tags ? "name" : f.faq_tags.min_by(&:name) }
          faqs_data = faqs_data.order("faq_tags.name" => :asc)
          faqs_data = faqs_data.offset(0).limit(data_qty + 50 - 1).includes(:faq_tags)
          faqs = faqs_data.map do |faq|
            { faq:, tags: faq.faq_tags }
          end
          render json: { faqs:, length:, options: }, status: :ok
        end
      end
    end
  end
end
