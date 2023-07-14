# frozen_string_literal: true

require_relative "base"

module Sample
  class Visit < Sample::Base
    def simulate_job(count = 1)
      click_on_main_page({ code: "job", name: "ប្រភេទមុខរបរ" })

      count.times.each do |i|
        click_on_page_detail(Job.all.sample, {
          code: "job_detail",
          name: "job detail",
          parent_code: "job"
        })
      end
    end

    def simulate_video(count = 1)
      click_on_main_page({ code: "video", name: "វីដេអូមុខរបរ" })

      count.times.each do |i|
        click_on_page_detail(Video.all.sample, {
          code: "video_detail",
          name: "video detail",
          parent_code: "video"
        })
      end
    end

    def simulate_school(count = 1)
      click_on_main_page({ code: "school", name: "គ្រឹះស្ថានសិក្សា" })

      count.times.each do |i|
        click_on_page_detail(School.all.sample, {
          code: "school_detail",
          name: "school detail",
          parent_code: "school"
        })
      end
    end

    private
      def click_on_page_detail(pageable, page_attributes = {})
        ::Visit.create(
          user_id: user_id,
          visit_date: rand(1..100).days.ago,
          pageable: pageable,
          page_attributes: page_attributes,
          device_os: ::Visit.device_os.keys.sample
        )
      end

      def click_on_main_page(page_attributes = {})
        ::Visit.create(
          user_id: user_id,
          visit_date: rand(1..100).days.ago,
          page_attributes: page_attributes,
          device_os: ::Visit.device_os.keys.sample
        )
      end

      def user_id
        [::User.all.sample.id, ::User::PUBLIC_USER_ID].sample
      end
  end
end
