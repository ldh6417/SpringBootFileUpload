package com.zeus.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zeus.domain.Item;
import com.zeus.mapper.ItemMapper;

@Service
public class ItemServiceimpl implements ItemService {
	@Autowired
	private ItemMapper itemMapper;
	
	@Override
	public int create(Item item) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Item read(Item itemId) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int update(Item item) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Item item) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Item> list() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getPicture(Item item) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
