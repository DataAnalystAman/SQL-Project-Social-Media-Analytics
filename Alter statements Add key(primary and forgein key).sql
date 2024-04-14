alter table users
add primary key (user_id);

alter table post
add foreign key (user_id) references users(user_id);

alter table post
add primary key (post_id);

alter table videos
add primary key (video_id),
add foreign key (post_id) references post(post_id);

alter table photos
add primary key (photo_id),
add foreign key (post_id) references post(post_id);

alter table comments
add primary key (comment_id),
add foreign key (post_id) references post(post_id),
add foreign key (user_id) references users(user_id);

alter table comment_likes
add foreign key (comment_id) references comments(comment_id),
add foreign key (user_id) references users(user_id);

alter table post_likes
add foreign key (post_id) references post(post_id),
add foreign key (user_id) references users(user_id);

alter table video_id
add foreign key (post_id) references post(post_id),
add foreign key (user_id) references users(user_id);




