package com.itbank.review;

import com.fasterxml.jackson.databind.JsonNode;

public class MovieJson {

	private String title,link,image,pubDate,director,actor,userRating,moviecode;



	public MovieJson(JsonNode item) {
		this.title = item.get("title").toString();
		this.link = item.get("link").toString();
		this.image = item.get("image").toString();
		this.pubDate = item.get("pubDate").toString();
		this.director = item.get("director").toString();
		this.actor = item.get("actor").toString();
		this.userRating= item.get("userRating").toString();
		this.moviecode = item.get("link").toString().split("=")[1];
	}
	
	public String getMoviecode() {
		return moviecode;
	}
	
	public void setMoviecode(String moviecode) {
		this.moviecode = moviecode;
	}
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPubDate() {
		return pubDate;
	}

	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public String getUserRating() {
		return userRating;
	}

	public void setUserRating(String userRating) {
		this.userRating = userRating;
	}
	
	
}
