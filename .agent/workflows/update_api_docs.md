---
description: Update the Postman Collection documentation
---

# Update Postman Collection

When API endpoints are created or modified, the Postman collection at `docs/api/tachyon_api.postman_collection.json` must be updated to reflect these changes.

## Steps

1.  **Analyze Changes**: Review the recent modifications to route handlers in `backend/tachyon_api/routes`.
2.  **Read Collection**: Read the existing `docs/api/tachyon_api.postman_collection.json` file.
3.  **Update JSON**:
    *   **New Endpoint**: Add a new item to the appropriate folder (e.g., Auth, User) with the correct method, URL, and body example.
    *   **Modified Endpoint**: Update the request body, URL, or headers of the existing item.
    *   **Deleted Endpoint**: Remove the corresponding item.
4.  **Save**: Write the updated JSON back to `docs/api/tachyon_api.postman_collection.json`.
5.  **Verify**: Ensure the JSON is valid and imports correctly if testing is needed.
