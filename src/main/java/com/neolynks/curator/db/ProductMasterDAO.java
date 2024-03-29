package com.neolynks.curator.db;

import io.dropwizard.hibernate.AbstractDAO;

import java.util.List;

import org.apache.commons.collections4.CollectionUtils;
import org.hibernate.Query;
import org.hibernate.SessionFactory;

import com.google.common.base.Optional;
import com.neolynks.curator.core.ProductMaster;

/**
 * Created by nitesh.garg on 25-Aug-2015
 */
public class ProductMasterDAO extends AbstractDAO<ProductMaster> {
	public ProductMasterDAO(SessionFactory factory) {
		super(factory);
	}

	public Optional<ProductMaster> findById(Long id) {
		return Optional.fromNullable(get(id));
	}

	public ProductMaster create(ProductMaster productCore) {
		return persist(productCore);
	}

	public List<ProductMaster> findAll() {
		return list(namedQuery("com.example.helloworld.core.ProductMaster.findAll"));
	}

	public ProductMaster findByBarcode(Long barcode) {
		return list(
				namedQuery("com.example.helloworld.core.ProductMaster.fetchByBarcode").setParameter("barcode", barcode))
				.get(0);
	}

	@SuppressWarnings("unchecked")
	public List<ProductMaster> findByVendor(Long vendorId) {
		Query query = this.currentSession()
				.createSQLQuery("select pm.* from product_master pm where vendor_id ilike :vendorIdPattern")
				.addEntity("product_master", ProductMaster.class)
				.setParameter("vendorIdPattern", "%" + String.valueOf(vendorId) + "%");
		List<ProductMaster> productMasterListForVendor = query.list();

		return productMasterListForVendor;
	}

	public List<ProductMaster> findExclusiveToVendor(Long vendorId) {
		return list(namedQuery("com.example.helloworld.core.ProductMaster.findExclusiveToVendor").setParameter(
				"vendorId", String.valueOf(vendorId)));
	}

	public void deleteExclusiveToVendor(Long vendorId) {
		List<ProductMaster> productMasterByVendorDetails = findExclusiveToVendor(vendorId);
		if (CollectionUtils.isNotEmpty(productMasterByVendorDetails)) {
			for (ProductMaster instance : productMasterByVendorDetails) {
				this.currentSession().delete(instance);
			}
		}
	}

}
