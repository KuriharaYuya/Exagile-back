module CharactersCommunitiesHelper
  def return_characters_communities(community_id = nil)
    p "うす"
    characters = if community_id.nil?
                   current_user.characters.includes(:communities)
                 else
                   community = Community.find(community_id)
                   community.characters.includes(:communities)
                 end
    characters_with_community = characters.map do |character|
      {
        character:,
        communities: character.communities.sort_by(&:created_at)
      }
    end
    characters_with_community.sort_by { |c| c[:communities].blank? ? Time.now : c[:communities].min_by(&:created_at).created_at }
  end
end
