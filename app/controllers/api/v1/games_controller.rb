# frozen_string_literal: true

class Api::V1::GamesController < ApiController
  def create
    params["data"] = JSON.parse(params["data"])
    user = User.find_by(uuid: params["data"]["user_uuid"])

    return head :forbidden if user.nil?

    game = user.games.build(game_params)
    game.audio = params[:audio]

    begin
      game.save!
      game.entries = Entry.where(name: params["data"]["characteristic_entries"])
      render json: { success: true, game: }, status: :created
    rescue ActiveRecord::RecordInvalid
      Log.create(game: params["data"], version: params["data"]["version"])
      render json: { error: game.errors }, status: :unprocessable_entity
    end
  end

  private
    def game_params
      params.require(:data).permit(
        :reason, :audio, :characteristic_id, :goal,
        personal_understandings_attributes: %i[
          are_you_going_to_study_till_grade12
          are_your_parents_allow_you_to_study_till_grade12
          have_you_ever_thought_of_career
          career_name how_to_reach_career_goal does_parents_agree_with
          ever_talked_with_anyone_about_career how_to_reach_job_vacancy
          score
        ],
        subject_attributes: %i[
          khmer_reading khmer_writing english math
          social_study_ethics_and_citizenship social_study_geography
          social_study_history science_physics science_chemistry
          science_biology soft_skill_communication soft_skill_brave
          soft_skill_teamwork soft_skill_problem_solving soft_skill_public_speaking
        ],
        career_games_attributes: %i[career_code is_goal]
      )
    end
end
