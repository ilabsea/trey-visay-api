# frozen_string_literal: true

require_relative "base"

module Sample
  class Visit < Sample::Base
    def simulate_all(count = 1)
      count.times.each do |i|
        pages.each do |page|
          simulate(page)
        end
      end
    end

    def simulate(page, count = 1)
      click_on_main_page(page.slice(:code, :name))

      count.times.each do |i|
        click_on_page_detail(
          page[:model].constantize.limit(100).sample,
          page[:child].merge(parent_code: page[:code])
        )
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
        [::User.limit(100).sample.id, ::User::PUBLIC_USER_ID].sample
      end

      def pages
        @pages ||= [
          { code: "job", name: "អាជីពការងារ", child: { code: "job_detail", name: "job detail" }, model: "Job" },
          { code: "video", name: "វីដេអូមុខរបរ", child: { code: "video_detail", name: "video detail" }, model: "Video" },
          { code: "school", name: "គ្រឹះស្ថានសិក្សា", child: { code: "school_detail", name: "school detail" }, model: "School" },
          { code: "major", name: "មុខជំនាញសិក្សា", child: { code: "major_detail", name: "major detail" }, model: "Major" },
          { code: "career_website", name: "មជ្ឈមណ្ឌលការងារ", child: { code: "career_website_detail", name: "career website detail" }, model: "CareerWebsite" }
        ]
      end
  end
end
