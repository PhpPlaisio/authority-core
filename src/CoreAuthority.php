<?php
declare(strict_types=1);

namespace Plaisio\Authority;

use Plaisio\PlaisioObject;

/**
 * Core implementation of Authority.
 */
class CoreAuthority extends PlaisioObject implements Authority
{
  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Returns true if the current user has access to a page.
   *
   * @param int $pagId The ID of the page.
   *
   * @return bool
   *
   * @since 1.0.0
   * @api
   */
  public function hasAccessToPage(int $pagId): bool
  {
    return !empty($this->nub->DL->abcAuthGetPageAuth($this->nub->company->cmpId,
                                                     $this->nub->session->proId,
                                                     $pagId));
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Grants a role to a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rolId The ID of the role.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userGrantRole(int $usrId, int $rolId): void
  {
    $this->nub->DL->abcUserRoleGrantRole($this->nub->company->cmpId,
                                         $usrId,
                                         $rolId,
                                         date('Y-m-d'),
                                         '9999-12-31');
    $this->nub->DL->abcProfileProperUser($this->nub->company->cmpId, $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Returns true if a user has access to a page.
   *
   * @param int $usrId The ID of the user.
   * @param int $pagId The ID of the page.
   *
   * @return bool
   *
   * @since 1.0.0
   * @api
   */
  public function userHasAccessToPage(int $usrId, int $pagId): bool
  {
    return $this->nub->DL->abcAuthorityCoreUserHasAccessToPage($this->nub->company->cmpId, $usrId, $pagId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes a role from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rolId The ID of the role.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRole(int $usrId, int $rolId): void
  {
    $this->nub->DL->abcUserRoleRevokeRole($this->nub->company->cmpId, $usrId, $rolId);
    $this->nub->DL->abcProfileProperUser($this->nub->company->cmpId, $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes all roles of a role group from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rlgId The ID of the role group.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRoleGroup(int $usrId, int $rlgId): void
  {
    $roles = $this->nub->DL->abcSystemRoleGroupGetRoles($rlgId);
    foreach ($roles as $role)
    {
      $this->nub->DL->abcUserRoleRevokeRole($this->nub->company->cmpId, $usrId, $role['rol_id']);
    }
    $this->nub->DL->abcProfileProperUser($this->nub->company->cmpId, $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
}

//----------------------------------------------------------------------------------------------------------------------
