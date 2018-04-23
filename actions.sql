CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE actions
(
	id uuid DEFAULT uuid_generate_v4 (),
	action varchar(32),
	agency_id integer,
	user_id integer,
	visitor_id uuid,
	session_id varchar,
	obj varchar,
	obj_id integer,
	ref_domain varchar,
	referer varchar(2048),
	request varchar(2048),
	keyword varchar(1024),
	ip varchar(32),
	ua varchar(1024),
	device varchar,
	mobile boolean,
	geoname_id integer,
	country_code varchar(3),
	utm_source varchar,
	utm_medium varchar,
	utm_campaign varchar,
	utm_term varchar,
	utm_content varchar,
	inserted_at timestamp without time zone
);

CREATE UNIQUE INDEX actions_session_id ON actions (session_id);
CREATE INDEX actions_action ON actions (action);
CREATE INDEX actions_site_id ON actions (agency_id);
CREATE INDEX actions_user_id ON actions (user_id);
CREATE INDEX actions_visitor_id ON actions (visitor_id);
CREATE INDEX actions_obj_obj_id ON actions (obj, obj_id);
CREATE INDEX actions_geoname_id ON actions (geoname_id);
CREATE INDEX actions_country_code ON actions (country_code);
CREATE INDEX actions_inserted_at ON actions (inserted_at);
create index actions_ref_domain on actions (ref_domain);
