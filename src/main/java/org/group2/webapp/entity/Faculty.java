/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.group2.webapp.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 *
 * @author dfChicken
 */
@Entity
@Table(name = "faculty")
public class Faculty implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Size(min = 1, max = 100)
	@Column(length = 100, unique = true, nullable = false)
	private String title;

	@OneToMany(mappedBy = "faculty")
	@JsonIgnore
	private Set<User> users;

	@OneToMany(mappedBy = "faculty")
	@JsonIgnore
	private Set<Assessment> courses;

	public Faculty() {
	}

	public Faculty(String title) {
		super();
		this.title = title;
	}

	public Set<Assessment> getCourses() {
		return courses;
	}

	public void setCourses(Set<Assessment> courses) {
		this.courses = courses;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}


	@Override
	public String toString() {
		return "Faculty{" +
				"id=" + id +
				", title='" + title + '\'' +
				'}';
	}
}
