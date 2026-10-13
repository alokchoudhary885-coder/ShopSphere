package com.shopsphere.service;

import com.shopsphere.dao.CategoryDAO;
import com.shopsphere.dao.ProductDAO;
import com.shopsphere.dao.ReviewDAO;
import com.shopsphere.model.Category;
import com.shopsphere.model.Product;
import com.shopsphere.model.Review;

import java.math.BigDecimal;
import java.util.List;

/**
 * Service layer for product catalog browsing, category management,
 * review submissions, and admin inventory operations.
 * Enforces validation rules and delegates to DAO layer.
 */
public class ProductService {

    private final ProductDAO productDAO;
    private final CategoryDAO categoryDAO;
    private final ReviewDAO reviewDAO;

    public ProductService() {
        this.productDAO = new ProductDAO();
        this.categoryDAO = new CategoryDAO();
        this.reviewDAO = new ReviewDAO();
    }

    // =========================================================================
    // Product Browsing (Customer)
    // =========================================================================

    public Product getProductById(int id) {
        return productDAO.findById(id);
    }

    public List<Product> getAllProducts() {
        return productDAO.findAll();
    }

    public List<Product> getFeaturedProducts(int limit) {
        return productDAO.findFeatured(limit > 0 ? limit : 8);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.findByCategory(categoryId);
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return productDAO.findAll();
        }
        return productDAO.search(keyword.trim());
    }

    /**
     * Retrieves products matching multiple filter criteria with pagination.
     *
     * @param categoryId optional category filter
     * @param brand      optional brand filter
     * @param minPrice   optional minimum price
     * @param maxPrice   optional maximum price
     * @param minRating  optional minimum star rating
     * @param sortBy     sort option: "price_asc", "price_desc", "rating", "newest"
     * @param page       1-based page number
     * @param pageSize   items per page
     * @return filtered, sorted, paginated product list
     */
    public List<Product> getFilteredProducts(Integer categoryId, String brand,
                                              BigDecimal minPrice, BigDecimal maxPrice,
                                              Integer minRating, String sortBy,
                                              int page, int pageSize) {
        int safePage = Math.max(1, page);
        int safeSize = Math.max(1, Math.min(pageSize, 100));
        int offset = (safePage - 1) * safeSize;
        return productDAO.findWithFilters(categoryId, brand, minPrice, maxPrice,
                minRating, sortBy, offset, safeSize);
    }

    public int countFilteredProducts(Integer categoryId, String brand,
                                      BigDecimal minPrice, BigDecimal maxPrice,
                                      Integer minRating) {
        return productDAO.countWithFilters(categoryId, brand, minPrice, maxPrice, minRating);
    }

    // =========================================================================
    // Categories
    // =========================================================================

    public List<Category> getAllCategories() {
        return categoryDAO.findAll();
    }

    public List<Category> getActiveCategories() {
        return categoryDAO.findAllActive();
    }

    public Category getCategoryById(int id) {
        return categoryDAO.findById(id);
    }

    public List<String> getAllBrands() {
        return productDAO.findAllBrands();
    }

    // =========================================================================
    // Admin: Product CRUD
    // =========================================================================

    public boolean addProduct(Product product) {
        if (product == null || product.getName() == null || product.getName().trim().isEmpty()) {
            return false;
        }
        if (product.getPrice() == null || product.getPrice().compareTo(BigDecimal.ZERO) < 0) {
            return false;
        }
        return productDAO.insert(product);
    }

    public boolean updateProduct(Product product) {
        if (product == null || product.getId() <= 0) {
            return false;
        }
        return productDAO.update(product);
    }

    public boolean deleteProduct(int productId) {
        return productDAO.delete(productId);
    }

    public boolean updateStock(int productId, int quantity) {
        if (quantity < 0) {
            return false;
        }
        return productDAO.updateStock(productId, quantity);
    }

    // =========================================================================
    // Admin: Category CRUD
    // =========================================================================

    public boolean addCategory(Category category) {
        if (category == null || category.getName() == null || category.getName().trim().isEmpty()) {
            return false;
        }
        return categoryDAO.insert(category);
    }

    public boolean updateCategory(Category category) {
        if (category == null || category.getId() <= 0) {
            return false;
        }
        return categoryDAO.update(category);
    }

    public boolean deleteCategory(int categoryId) {
        // Prevent deletion if category has products
        int productCount = categoryDAO.countProducts(categoryId);
        if (productCount > 0) {
            return false;
        }
        return categoryDAO.delete(categoryId);
    }

    // =========================================================================
    // Reviews
    // =========================================================================

    public boolean addReview(Review review) {
        if (review == null || review.getUserId() <= 0 || review.getProductId() <= 0) {
            return false;
        }
        if (review.getRating() < 1 || review.getRating() > 5) {
            return false;
        }
        boolean inserted = reviewDAO.insert(review);
        if (inserted) {
            // Recalculate product average rating and review count
            productDAO.updateRatingStats(review.getProductId());
        }
        return inserted;
    }

    public List<Review> getProductReviews(int productId) {
        return reviewDAO.findByProductId(productId);
    }

    // =========================================================================
    // Dashboard Metrics
    // =========================================================================

    public int getTotalProductCount() {
        return productDAO.countAll();
    }

    public int getOutOfStockCount() {
        return productDAO.countOutOfStock();
    }
}
