package net.java_school.blog;

import java.util.Date;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Cache;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
@Cache
public class Article {
	@Parent Key<Category> theCategory;
	@Id public String id;

	public String owner;
	@Index public String title;
	public String keywords;
	public String description;
	public String content;
	@Index public Date date;
	public Date lastModified;

	public Key<Article> getKey() {
		return Key.create(theCategory, Article.class, id);
	}
	public String getKeyString() {
		return getKey().toWebSafeString();
	}
	public Key<Category> getTheCategory() {
		return theCategory;
	}
	public void setTheCategory(Key<Category> theCategory) {
		this.theCategory = theCategory;
	}
	public String getCategory() {
		return theCategory.getName();
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public Date getLastModified() {
		return lastModified;
	}
	public void setLastModified(Date lastModified) {
		this.lastModified = lastModified;
	}

}