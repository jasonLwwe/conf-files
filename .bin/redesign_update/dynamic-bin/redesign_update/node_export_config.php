#! /bin/env drush

# set the export format to serialize
#php -r "print json_encode(array('serialize'=>'serialize', 'json'=>0, 'drupal' => 0, 'xml' => 0,'dsv' => 0));" | drush vset --format=json node_export_format -
$export_format = array('serialize'=>'serialize', 'json'=>0, 'drupal' => 0, 'xml' => 0,'dsv' => 0);
variable_set('node_export_format', $export_format);

#set file export mode to local
variable_set('node_export_file_mode', 'inline');

variable_set('node_export_existing', 'revision');

# set exporting of file fields to on for all content types
#php -r "print json_encode( \
#	array( \
#		'article' => 'article', \
#		'page' => 'page', \
#		'breaking_news' => 'breaking_news', \
#		'championship' => 'championship', \
#		'entity_content_pane' => \
#		'entity_content_pane', \
#		'episode' => 'episode', \
#		'event' => 'event', \
#		'gallery' => 'gallery', \
#		'link' => 'link', \
#		'match' => 'match', \
#		'reign' => 'reign', \
#		'show' => 'show', \
#		'social' => 'social', \
#		'talent' => 'talent', \
#		'video' => 'video', \
#		'video_playlist' => 'video_playlist', \
#		'webform' => 'webform' ));" | drush vset --format=json node_export_file_types -

$export_file_types = array(
  'article' => 'article',
  'page' => 'page', 
  'breaking_news' => 'breaking_news',
  'championship' => 'championship',
  'entity_content_pane' => 'entity_content_pane',
  'episode' => 'episode',
  'event' => 'event',
  'gallery' => 'gallery',
  'link' => 'link',
  'match' => 'match',
  'reign' => 'reign',
  'show' => 'show',
  'social' => 'social',
  'talent' => 'talent',
  'video' => 'video',
  'video_playlist' => 'video_playlist',
  'webform' => 'webform');
variable_set('node_export_file_types', $export_file_types);


# set import setting for existing nodes to revision
#drush vset node_export_existing 'revision'
variable_set('node_export_existing', 'revision');


# set the reset values on import to 0 for all items
#drush vset node_export_reset_author_article 0
#drush vset node_export_reset_author_breaking_news 0
#drush vset node_export_reset_author_championship 0
#drush vset node_export_reset_author_entity_content_pane 0
#drush vset node_export_reset_author_episode 0
#drush vset node_export_reset_author_event 0
#drush vset node_export_reset_author_gallery 0
#drush vset node_export_reset_author_link 0
#drush vset node_export_reset_author_match 0
#drush vset node_export_reset_author_page 0
#drush vset node_export_reset_author_reign 0
#drush vset node_export_reset_author_show 0
#drush vset node_export_reset_author_social 0
#drush vset node_export_reset_author_talent 0
#drush vset node_export_reset_author_video 0
#drush vset node_export_reset_author_video_playlist 0
#drush vset node_export_reset_author_webform 0
#drush vset node_export_reset_book_mlid_article 0
#drush vset node_export_reset_book_mlid_breaking_news 0
#drush vset node_export_reset_book_mlid_championship 0
#drush vset node_export_reset_book_mlid_entity_content_pane 0
#drush vset node_export_reset_book_mlid_episode 0
#drush vset node_export_reset_book_mlid_event 0
#drush vset node_export_reset_book_mlid_gallery 0
#drush vset node_export_reset_book_mlid_link 0
#drush vset node_export_reset_book_mlid_match 0
#drush vset node_export_reset_book_mlid_page 0
#drush vset node_export_reset_book_mlid_reign 0
#drush vset node_export_reset_book_mlid_show 0
#drush vset node_export_reset_book_mlid_social 0
#drush vset node_export_reset_book_mlid_talent 0
#drush vset node_export_reset_book_mlid_video 0
#drush vset node_export_reset_book_mlid_video_playlist 0
#drush vset node_export_reset_book_mlid_webform 0
#drush vset node_export_reset_changed_article 0
#drush vset node_export_reset_changed_breaking_news 0
#drush vset node_export_reset_changed_championship 0
#drush vset node_export_reset_changed_entity_content_pane 0
#drush vset node_export_reset_changed_episode 0
#drush vset node_export_reset_changed_event 0
#drush vset node_export_reset_changed_gallery 0
#drush vset node_export_reset_changed_link 0
#drush vset node_export_reset_changed_match 0
#drush vset node_export_reset_changed_page 0
#drush vset node_export_reset_changed_reign 0
#drush vset node_export_reset_changed_show 0
#drush vset node_export_reset_changed_social 0
#drush vset node_export_reset_changed_talent 0
#drush vset node_export_reset_changed_video 0
#drush vset node_export_reset_changed_video_playlist 0
#drush vset node_export_reset_changed_webform 0
#drush vset node_export_reset_created_article 0
#drush vset node_export_reset_created_breaking_news 0
#drush vset node_export_reset_created_championship 0
#drush vset node_export_reset_created_entity_content_pane 0
#drush vset node_export_reset_created_episode 0
#drush vset node_export_reset_created_event 0
#drush vset node_export_reset_created_gallery 0
#drush vset node_export_reset_created_link 0
#drush vset node_export_reset_created_match 0
#drush vset node_export_reset_created_page 0
#drush vset node_export_reset_created_reign 0
#drush vset node_export_reset_created_show 0
#drush vset node_export_reset_created_social 0
#drush vset node_export_reset_created_talent 0
#drush vset node_export_reset_created_video 0
#drush vset node_export_reset_created_video_playlist 0
#drush vset node_export_reset_created_webform 0
#drush vset node_export_reset_last_comment_timestamp_article 0
#drush vset node_export_reset_last_comment_timestamp_breaking_news 0
#drush vset node_export_reset_last_comment_timestamp_championship 0
#drush vset node_export_reset_last_comment_timestamp_entity_content_pane 0
#drush vset node_export_reset_last_comment_timestamp_episode 0
#drush vset node_export_reset_last_comment_timestamp_event 0
#drush vset node_export_reset_last_comment_timestamp_gallery 0
#drush vset node_export_reset_last_comment_timestamp_link 0
#drush vset node_export_reset_last_comment_timestamp_match 0
#drush vset node_export_reset_last_comment_timestamp_page 0
#drush vset node_export_reset_last_comment_timestamp_reign 0
#drush vset node_export_reset_last_comment_timestamp_show 0
#drush vset node_export_reset_last_comment_timestamp_social 0
#drush vset node_export_reset_last_comment_timestamp_talent 0
#drush vset node_export_reset_last_comment_timestamp_video 0
#drush vset node_export_reset_last_comment_timestamp_video_playlist 0
#drush vset node_export_reset_last_comment_timestamp_webform 0
#drush vset node_export_reset_menu_article 0
#drush vset node_export_reset_menu_breaking_news 0
#drush vset node_export_reset_menu_championship 0
#drush vset node_export_reset_menu_entity_content_pane 0
#drush vset node_export_reset_menu_episode 0
#drush vset node_export_reset_menu_event 0
#drush vset node_export_reset_menu_gallery 0
#drush vset node_export_reset_menu_link 0
#drush vset node_export_reset_menu_match 0
#drush vset node_export_reset_menu_page 0
#drush vset node_export_reset_menu_reign 0
#drush vset node_export_reset_menu_show 0
#drush vset node_export_reset_menu_social 0
#drush vset node_export_reset_menu_talent 0
#drush vset node_export_reset_menu_video 0
#drush vset node_export_reset_menu_video_playlist 0
#drush vset node_export_reset_menu_webform 0
#drush vset node_export_reset_path_article 0
#drush vset node_export_reset_path_breaking_news 0
#drush vset node_export_reset_path_championship 0
#drush vset node_export_reset_path_entity_content_pane 0
#drush vset node_export_reset_path_episode 0
#drush vset node_export_reset_path_event 0
#drush vset node_export_reset_path_gallery 0
#drush vset node_export_reset_path_link 0
#drush vset node_export_reset_path_match 0
#drush vset node_export_reset_path_page 0
#drush vset node_export_reset_path_reign 0
#drush vset node_export_reset_path_show 0
#drush vset node_export_reset_path_social 0
#drush vset node_export_reset_path_talent 0
#drush vset node_export_reset_path_video 0
#drush vset node_export_reset_path_video_playlist 0
#drush vset node_export_reset_path_webform 0
#drush vset node_export_reset_promote_article 0
#drush vset node_export_reset_promote_breaking_news 0
#drush vset node_export_reset_promote_championship 0
#drush vset node_export_reset_promote_entity_content_pane 0
#drush vset node_export_reset_promote_episode 0
#drush vset node_export_reset_promote_event 0
#drush vset node_export_reset_promote_gallery 0
#drush vset node_export_reset_promote_link 0
#drush vset node_export_reset_promote_match 0
#drush vset node_export_reset_promote_page 0
#drush vset node_export_reset_promote_reign 0
#drush vset node_export_reset_promote_show 0
#drush vset node_export_reset_promote_social 0
#drush vset node_export_reset_promote_talent 0
#drush vset node_export_reset_promote_video 0
#drush vset node_export_reset_promote_video_playlist 0
#drush vset node_export_reset_promote_webform 0
#drush vset node_export_reset_revision_timestamp_article 0
#drush vset node_export_reset_revision_timestamp_breaking_news 0
#drush vset node_export_reset_revision_timestamp_championship 0
#drush vset node_export_reset_revision_timestamp_entity_content_pane 0
#drush vset node_export_reset_revision_timestamp_episode 0
#drush vset node_export_reset_revision_timestamp_event 0
#drush vset node_export_reset_revision_timestamp_gallery 0
#drush vset node_export_reset_revision_timestamp_link 0
#drush vset node_export_reset_revision_timestamp_match 0
#drush vset node_export_reset_revision_timestamp_page 0
#drush vset node_export_reset_revision_timestamp_reign 0
#drush vset node_export_reset_revision_timestamp_show 0
#drush vset node_export_reset_revision_timestamp_social 0
#drush vset node_export_reset_revision_timestamp_talent 0
#drush vset node_export_reset_revision_timestamp_video 0
#drush vset node_export_reset_revision_timestamp_video_playlist 0
#drush vset node_export_reset_revision_timestamp_webform 0
#drush vset node_export_reset_status_article 0
#drush vset node_export_reset_status_breaking_news 0
#drush vset node_export_reset_status_championship 0
#drush vset node_export_reset_status_entity_content_pane 0
#drush vset node_export_reset_status_episode 0
#drush vset node_export_reset_status_event 0
#drush vset node_export_reset_status_gallery 0
#drush vset node_export_reset_status_link 0
#drush vset node_export_reset_status_match 0
#drush vset node_export_reset_status_page 0
#drush vset node_export_reset_status_reign 0
#drush vset node_export_reset_status_show 0
#drush vset node_export_reset_status_social 0
#drush vset node_export_reset_status_talent 0
#drush vset node_export_reset_status_video 0
#drush vset node_export_reset_status_video_playlist 0
#drush vset node_export_reset_status_webform 0
#drush vset node_export_reset_sticky_article 0
#drush vset node_export_reset_sticky_breaking_news 0
#drush vset node_export_reset_sticky_championship 0
#drush vset node_export_reset_sticky_entity_content_pane 0
#drush vset node_export_reset_sticky_episode 0
#drush vset node_export_reset_sticky_event 0
#drush vset node_export_reset_sticky_gallery 0
#drush vset node_export_reset_sticky_link 0
#drush vset node_export_reset_sticky_match 0
#drush vset node_export_reset_sticky_page 0
#drush vset node_export_reset_sticky_reign 0
#drush vset node_export_reset_sticky_show 0
#drush vset node_export_reset_sticky_social 0
#drush vset node_export_reset_sticky_talent 0
#drush vset node_export_reset_sticky_video 0
#drush vset node_export_reset_sticky_video_playlist 0
#drush vset node_export_reset_sticky_webform 0

variable_set('node_export_reset_author_article', 0);
variable_set('node_export_reset_author_breaking_news', 0);
variable_set('node_export_reset_author_championship', 0);
variable_set('node_export_reset_author_entity_content_pane', 0);
variable_set('node_export_reset_author_episode', 0);
variable_set('node_export_reset_author_event', 0);
variable_set('node_export_reset_author_gallery', 0);
variable_set('node_export_reset_author_link', 0);
variable_set('node_export_reset_author_match', 0);
variable_set('node_export_reset_author_page', 0);
variable_set('node_export_reset_author_reign', 0);
variable_set('node_export_reset_author_show', 0);
variable_set('node_export_reset_author_social', 0);
variable_set('node_export_reset_author_talent', 0);
variable_set('node_export_reset_author_video', 0);
variable_set('node_export_reset_author_video_playlist', 0);
variable_set('node_export_reset_author_webform', 0);
variable_set('node_export_reset_book_mlid_article', 0);
variable_set('node_export_reset_book_mlid_breaking_news', 0);
variable_set('node_export_reset_book_mlid_championship', 0);
variable_set('node_export_reset_book_mlid_entity_content_pane', 0);
variable_set('node_export_reset_book_mlid_episode', 0);
variable_set('node_export_reset_book_mlid_event', 0);
variable_set('node_export_reset_book_mlid_gallery', 0);
variable_set('node_export_reset_book_mlid_link', 0);
variable_set('node_export_reset_book_mlid_match', 0);
variable_set('node_export_reset_book_mlid_page', 0);
variable_set('node_export_reset_book_mlid_reign', 0);
variable_set('node_export_reset_book_mlid_show', 0);
variable_set('node_export_reset_book_mlid_social', 0);
variable_set('node_export_reset_book_mlid_talent', 0);
variable_set('node_export_reset_book_mlid_video', 0);
variable_set('node_export_reset_book_mlid_video_playlist', 0);
variable_set('node_export_reset_book_mlid_webform', 0);
variable_set('node_export_reset_changed_article', 0);
variable_set('node_export_reset_changed_breaking_news', 0);
variable_set('node_export_reset_changed_championship', 0);
variable_set('node_export_reset_changed_entity_content_pane', 0);
variable_set('node_export_reset_changed_episode', 0);
variable_set('node_export_reset_changed_event', 0);
variable_set('node_export_reset_changed_gallery', 0);
variable_set('node_export_reset_changed_link', 0);
variable_set('node_export_reset_changed_match', 0);
variable_set('node_export_reset_changed_page', 0);
variable_set('node_export_reset_changed_reign', 0);
variable_set('node_export_reset_changed_show', 0);
variable_set('node_export_reset_changed_social', 0);
variable_set('node_export_reset_changed_talent', 0);
variable_set('node_export_reset_changed_video', 0);
variable_set('node_export_reset_changed_video_playlist', 0);
variable_set('node_export_reset_changed_webform', 0);
variable_set('node_export_reset_created_article', 0);
variable_set('node_export_reset_created_breaking_news', 0);
variable_set('node_export_reset_created_championship', 0);
variable_set('node_export_reset_created_entity_content_pane', 0);
variable_set('node_export_reset_created_episode', 0);
variable_set('node_export_reset_created_event', 0);
variable_set('node_export_reset_created_gallery', 0);
variable_set('node_export_reset_created_link', 0);
variable_set('node_export_reset_created_match', 0);
variable_set('node_export_reset_created_page', 0);
variable_set('node_export_reset_created_reign', 0);
variable_set('node_export_reset_created_show', 0);
variable_set('node_export_reset_created_social', 0);
variable_set('node_export_reset_created_talent', 0);
variable_set('node_export_reset_created_video', 0);
variable_set('node_export_reset_created_video_playlist', 0);
variable_set('node_export_reset_created_webform', 0);
variable_set('node_export_reset_last_comment_timestamp_article', 0);
variable_set('node_export_reset_last_comment_timestamp_breaking_news', 0);
variable_set('node_export_reset_last_comment_timestamp_championship', 0);
variable_set('node_export_reset_last_comment_timestamp_entity_content_pane', 0);
variable_set('node_export_reset_last_comment_timestamp_episode', 0);
variable_set('node_export_reset_last_comment_timestamp_event', 0);
variable_set('node_export_reset_last_comment_timestamp_gallery', 0);
variable_set('node_export_reset_last_comment_timestamp_link', 0);
variable_set('node_export_reset_last_comment_timestamp_match', 0);
variable_set('node_export_reset_last_comment_timestamp_page', 0);
variable_set('node_export_reset_last_comment_timestamp_reign', 0);
variable_set('node_export_reset_last_comment_timestamp_show', 0);
variable_set('node_export_reset_last_comment_timestamp_social', 0);
variable_set('node_export_reset_last_comment_timestamp_talent', 0);
variable_set('node_export_reset_last_comment_timestamp_video', 0);
variable_set('node_export_reset_last_comment_timestamp_video_playlist', 0);
variable_set('node_export_reset_last_comment_timestamp_webform', 0);
variable_set('node_export_reset_menu_article', 0);
variable_set('node_export_reset_menu_breaking_news', 0);
variable_set('node_export_reset_menu_championship', 0);
variable_set('node_export_reset_menu_entity_content_pane', 0);
variable_set('node_export_reset_menu_episode', 0);
variable_set('node_export_reset_menu_event', 0);
variable_set('node_export_reset_menu_gallery', 0);
variable_set('node_export_reset_menu_link', 0);
variable_set('node_export_reset_menu_match', 0);
variable_set('node_export_reset_menu_page', 0);
variable_set('node_export_reset_menu_reign', 0);
variable_set('node_export_reset_menu_show', 0);
variable_set('node_export_reset_menu_social', 0);
variable_set('node_export_reset_menu_talent', 0);
variable_set('node_export_reset_menu_video', 0);
variable_set('node_export_reset_menu_video_playlist', 0);
variable_set('node_export_reset_menu_webform', 0);
variable_set('node_export_reset_path_article', 0);
variable_set('node_export_reset_path_breaking_news', 0);
variable_set('node_export_reset_path_championship', 0);
variable_set('node_export_reset_path_entity_content_pane', 0);
variable_set('node_export_reset_path_episode', 0);
variable_set('node_export_reset_path_event', 0);
variable_set('node_export_reset_path_gallery', 0);
variable_set('node_export_reset_path_link', 0);
variable_set('node_export_reset_path_match', 0);
variable_set('node_export_reset_path_page', 0);
variable_set('node_export_reset_path_reign', 0);
variable_set('node_export_reset_path_show', 0);
variable_set('node_export_reset_path_social', 0);
variable_set('node_export_reset_path_talent', 0);
variable_set('node_export_reset_path_video', 0);
variable_set('node_export_reset_path_video_playlist', 0);
variable_set('node_export_reset_path_webform', 0);
variable_set('node_export_reset_promote_article', 0);
variable_set('node_export_reset_promote_breaking_news', 0);
variable_set('node_export_reset_promote_championship', 0);
variable_set('node_export_reset_promote_entity_content_pane', 0);
variable_set('node_export_reset_promote_episode', 0);
variable_set('node_export_reset_promote_event', 0);
variable_set('node_export_reset_promote_gallery', 0);
variable_set('node_export_reset_promote_link', 0);
variable_set('node_export_reset_promote_match', 0);
variable_set('node_export_reset_promote_page', 0);
variable_set('node_export_reset_promote_reign', 0);
variable_set('node_export_reset_promote_show', 0);
variable_set('node_export_reset_promote_social', 0);
variable_set('node_export_reset_promote_talent', 0);
variable_set('node_export_reset_promote_video', 0);
variable_set('node_export_reset_promote_video_playlist', 0);
variable_set('node_export_reset_promote_webform', 0);
variable_set('node_export_reset_revision_timestamp_article', 0);
variable_set('node_export_reset_revision_timestamp_breaking_news', 0);
variable_set('node_export_reset_revision_timestamp_championship', 0);
variable_set('node_export_reset_revision_timestamp_entity_content_pane', 0);
variable_set('node_export_reset_revision_timestamp_episode', 0);
variable_set('node_export_reset_revision_timestamp_event', 0);
variable_set('node_export_reset_revision_timestamp_gallery', 0);
variable_set('node_export_reset_revision_timestamp_link', 0);
variable_set('node_export_reset_revision_timestamp_match', 0);
variable_set('node_export_reset_revision_timestamp_page', 0);
variable_set('node_export_reset_revision_timestamp_reign', 0);
variable_set('node_export_reset_revision_timestamp_show', 0);
variable_set('node_export_reset_revision_timestamp_social', 0);
variable_set('node_export_reset_revision_timestamp_talent', 0);
variable_set('node_export_reset_revision_timestamp_video', 0);
variable_set('node_export_reset_revision_timestamp_video_playlist', 0);
variable_set('node_export_reset_revision_timestamp_webform', 0);
variable_set('node_export_reset_status_article', 0);
variable_set('node_export_reset_status_breaking_news', 0);
variable_set('node_export_reset_status_championship', 0);
variable_set('node_export_reset_status_entity_content_pane', 0);
variable_set('node_export_reset_status_episode', 0);
variable_set('node_export_reset_status_event', 0);
variable_set('node_export_reset_status_gallery', 0);
variable_set('node_export_reset_status_link', 0);
variable_set('node_export_reset_status_match', 0);
variable_set('node_export_reset_status_page', 0);
variable_set('node_export_reset_status_reign', 0);
variable_set('node_export_reset_status_show', 0);
variable_set('node_export_reset_status_social', 0);
variable_set('node_export_reset_status_talent', 0);
variable_set('node_export_reset_status_video', 0);
variable_set('node_export_reset_status_video_playlist', 0);
variable_set('node_export_reset_status_webform', 0);
variable_set('node_export_reset_sticky_article', 0);
variable_set('node_export_reset_sticky_breaking_news', 0);
variable_set('node_export_reset_sticky_championship', 0);
variable_set('node_export_reset_sticky_entity_content_pane', 0);
variable_set('node_export_reset_sticky_episode', 0);
variable_set('node_export_reset_sticky_event', 0);
variable_set('node_export_reset_sticky_gallery', 0);
variable_set('node_export_reset_sticky_link', 0);
variable_set('node_export_reset_sticky_match', 0);
variable_set('node_export_reset_sticky_page', 0);
variable_set('node_export_reset_sticky_reign', 0);
variable_set('node_export_reset_sticky_show', 0);
variable_set('node_export_reset_sticky_social', 0);
variable_set('node_export_reset_sticky_talent', 0);
variable_set('node_export_reset_sticky_video', 0);
variable_set('node_export_reset_sticky_video_playlist', 0);
variable_set('node_export_reset_sticky_webform', 0);

return 0;
