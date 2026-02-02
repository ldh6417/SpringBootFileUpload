package com.zeus.mapper;

import java.util.List;

import com.zeus.domain.Item;

public interface ItemMapper {
	
	public int create(Item item) throws Exception;

	public Item read(Item itemId) throws Exception;

	public int update(Item item) throws Exception;

	public int delete(Item item) throws Exception;

	public List<Item> list() throws Exception;

	public String getPicture(Item item) throws Exception;
}
