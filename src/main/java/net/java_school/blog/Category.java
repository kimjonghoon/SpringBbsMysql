package net.java_school.blog;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Category {
	@Parent Key<Lang> theLang;
	@Id public String category;
}